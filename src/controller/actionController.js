import { prisma } from '../database/prismaClient.js'
export class ActionController {
  async incluir( request, response) {
    const { name, description } = request.body;
    const action = await prisma.action.create({
      data: {
        name,
        description
      }
    })
    return response.json(action);
  }
  async atualizar( request, response) {
    const { id, name, description } = request.body;
    const action = await prisma.action.update({
      where: { id },
      data: {
        name,
        description
      }
    })
    return response.json(action);
  }
  async excluir( request, response) {
    const { id } = request.body;
    const action = await prisma.action.delete({
      where: { id }
    })
    return response.json(action);
  }
  async excluirDados( request, response) {
    const action = await prisma.action.deleteMany({
    })
    return response.json(action);
  }
  async listar( request, response) {
    const action = await prisma.action.findMany({
    })
    return response.json(action);
  }
  async listarPorId( request, response) {
    const { id } = request.body;
    const action = await prisma.action.findUnique({
      where: { id }
    })
    return response.json(action);
  }
}