const express = require('express')
const { createServer } = require('node:http')
const { Server } = require('socket.io')
require('dotenv').config()
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const port = process.env.NODE_SERVER_PORT
const app = express()
const server = createServer(app)
const io = new Server(server, { cors: { origin: '*' } })

io.on('connection', (socket) => {
	socket.on('chat_message', async (payload) => {
		console.log(payload);

		const data = {
			from_user: payload.author,
			to_user: payload.to,
			content: payload.content,
		}
		await prisma.messages
			.create({
				data: data,
			})
			.then(() => io.emit('chat_message', payload))
	})
})

app.get('/', (_, res) => {
	return res.json({ message: 'hello, world!' })
})

server.listen(port, () => {
	console.log(`server running at :${port}`)
})