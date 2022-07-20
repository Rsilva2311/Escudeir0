import { Router } from "express"
import { DescriptionController } from "./controller/DescriptionController.js";
import { CharacterController } from "./controller/CharacterController.js";
import { ClassController } from "./controller/ClassController.js";

const router = Router()
const description = new DescriptionController()
const character = new CharacterController()
const classes = new ClassController()

//Descriptions
router.get("/listarDescription", description.listar)
router.get("/listarDescriptionPorId", description.listarPorId)
router.post("/incluirDescription", description.incluir)
router.put("/atualizarDescription", description.atualizar)
router.delete("/excluirDescription", description.excluir)
router.delete("/excluirDadosDescription", description.excluirDados)

//Character
router.get("/listarcharacter", character.listar)
router.get("/listarcharacterPorId", character.listarPorId)
router.post("/incluircharacter", character.incluir)
router.put("/atualizarcharacter", character.atualizar)
router.delete("/excluircharacter", character.excluir)
router.delete("/excluirDadoscharacter", character.excluirDados)

//Classes
router.get("/listarclass", classes.listar)
router.get("/listarclassPorId", classes.listarPorId)
router.post("/incluirclass", classes.incluir)
router.put("/atualizarclass", classes.atualizar)
router.put("/atualizarHabilidadeClasse", classes.atualizarHabilidadeClasse)
router.delete("/excluirclass", classes.excluir)
router.delete("/excluirDadosclass", classes.excluirDados)

export { router }
