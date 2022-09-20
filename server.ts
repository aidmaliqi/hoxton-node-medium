import express from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient({ log: ["info", "warn", "error", "query"] });
const app = express();
app.use(cors());
app.use(express.json());

const port = 3000;

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany();
  res.send(users);
});
app.get("/users/:id", async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: Number(req.params.id) },
    });
    res.send(user);
  } catch (error) {
    res.send(error);
  }
});

app.get("/posts", async (req, res) => {
  const posts = await prisma.posts.findMany({
    include: { user: true },
  });
  res.send(posts);
});
app.get("/posts/:id", async (req, res) => {
  let id = Number(req.params.id);
  try {
    const post = await prisma.posts.findUnique({
      where: { id: id },
      include: { paragraphs: true, user: true, img: true, commentText: true},
    });
    res.send(post);
  } catch (error) {
    res.send(error);
  }
});

app.post("/posts", async (req, res) => {
  try {
    const post = await prisma.posts.create({
      data: {
        claps: 0,
        comments: 0,
        paragraphs: {
          create: {
            text: req.body.text,
          },
        },
        title: req.body.title,
        img: {
          create: {
            img: req.body.img,
          },
        },
        user: {
          connect: { name: req.body.username },
        },
        lists: {
          connect: {
            id: req.body.listId,
          },
        },
      },
    });
    res.send(post);
  } catch (error) {
    res.send(error);
  }
});

app.patch("/posts/:id", async (req, res) => {
  try {
    const post = await prisma.posts.update({
      where: { id: Number(req.params.id) },
      data: {
        claps: { increment: 1 },
      },
    });
    res.send(post)
  } catch (error) {
    res.send(error);
  }
});

app.post("/posts/:id", async (req, res) => {
  try {
    const comment = await prisma.postComments.create({
      data: {
        text: req.body.comment,
        posts: { connect: { id: Number(req.params.id) } },
        user: { connect: { name: req.body.name } },
      },
      include: { posts: true, user: true },
    });
    res.send(comment);
  } catch (error) {
    res.send(error);
  }
});

app.listen(port, () => {
  console.log("app listening in port" + port);
});
