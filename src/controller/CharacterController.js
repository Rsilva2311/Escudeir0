import { prisma } from '../database/prismaClient.js'

export class CharacterController {
  async incluir( request, response) {
    const { name, description } = request.body;
    const Character = await prisma.character.create({
      data: {
        name,
        description
      }
    })
    return response.json(Character);
  }
  async atualizar( request, response) {
    const { id, name, description } = request.body;
    const Character = await prisma.character.update({
      where: { id },
      data: {
        name,
        description
      }
    })
    return response.json(Character);
  }
  async excluir( request, response) {
    const { id } = request.body;
    const character = await prisma.character.delete({
      where: { id }
    })
    return response.json(character);
  }
  async excluirDados( request, response) {
    const character = await prisma.character.deleteMany({
    })
    return response.json(character);
  }
  async listar( request, response) {
    const character = await prisma.character.findMany({
    })
    return response.json(character);
  }
  async listarPorId( request, response) {
    const { id } = request.body;
    const character = await prisma.character.findUnique({
      where: { id }
    })
    return response.json(character);
  }
}