import { Router } from "express"
import { ActionController } from "./controller/actionController.js";

const router = Router()
const createAction = new ActionController()

router.get("/listarAction", createAction.listar)
router.get("/listarActionPorId", createAction.listarPorId)
router.post("/incluirAction", createAction.incluir)
router.put("/atualizarAction", createAction.atualizar)
router.delete("/excluirAction", createAction.excluir)
router.delete("/excluirDadosAction", createAction.excluirDados)

export { router }
