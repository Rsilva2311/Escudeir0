import { prisma } from '../database/prismaClient.js'

export class ClassController {
  async incluir( request, response) {
    const { name, level, actionTime, recovery, descriptionId } = request.body;
    const Classes = await prisma.class.create({
      data: {
        name,
        classDescriptions: {
          create: {
            level,
            actionTime,
            recovery,
            descriptionId
          }
        }
      }
    })
    return response.json(Classes);
  }
  async atualizar( request, response) {
    const { id, name } = request.body;
    const Classes = await prisma.class.update({
      where: { id },
      data: {
        name
      }
    })
    return response.json(Classes);
  }
  async atualizarHabilidadeClasse( request, response) {
    const { id, level, actionTime, recovery } = request.body;
    const classDescriptions = await prisma.classDescription.update({
      where: { id },
      data: {
        level,
        actionTime,
        recovery
      }
    })
    return response.json(classDescriptions);
  }
  async excluir( request, response) {
    const { id } = request.body;
    const classes = await prisma.class.delete({
      where: { id }
    })
    return response.json(classes);
  }
  async excluirDados( request, response) {
    const classes = await prisma.class.deleteMany({
    })
    return response.json(classes);
  }
  async listar( request, response) {
    const classes = await prisma.class.findMany({
      select: {
        id: true,
        name: true,
        classDescriptions: {
          select: {
            level: true,
            actionTime: true,
            recovery: true,
            Descriptions: {
              select: {
                name: true,
                description: true
              }
            }
          }
        }
      }
    })
    return response.json(classes);
  }
  async listarPorId( request, response) {
    const { id } = request.body;
    const classes = await prisma.class.findUnique({
      where: { id },
      select: {
        name: true,
        classDescriptions: {
          select: {
            level: true,
            actionTime: true,
            recovery: true,
            Descriptions: {
              select: {
                name: true,
                description: true
              }
            }
          }
        }
      }
    })
    return response.json(classes);
  }
}