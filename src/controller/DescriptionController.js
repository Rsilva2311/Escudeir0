import { prisma } from '../database/prismaClient.js'
export class DescriptionController {
  async incluir( request, response) {
    const { name, description } = request.body;
    const actionDescription = await prisma.description.create({
      data: {
        name,
        description
      }
    })
    return response.json(actionDescription);
  }
  async atualizar( request, response) {
    const { id, name, description } = request.body;
    const actionDescription = await prisma.description.update({
      where: { id },
      data: {
        name,
        description
      }
    })
    return response.json(actionDescription);
  }
  async excluir( request, response) {
    const { id } = request.body;
    const description = await prisma.description.delete({
      where: { id }
    })
    return response.json(description);
  }
  async excluirDados( request, response) {
    const description = await prisma.description.deleteMany({
    })
    return response.json(description);
  }
  async listar( request, response) {
    const description = await prisma.description.findMany({
    })
    return response.json(description);
  }
  async listarPorId( request, response) {
    const { id } = request.body;
    const description = await prisma.description.findUnique({
      where: { id }
    })
    return response.json(description);
  }
}