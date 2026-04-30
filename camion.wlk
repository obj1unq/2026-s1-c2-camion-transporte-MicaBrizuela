// camion.wlk
// camion.wlk
// camion.wlk
import cosas.*

object camion {
	const property cosas = #{}
	var property tara = 1000
	var property pesoMaximoAceptable = 2500
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
	}

	method descargar(unaCosa){
		self.validarDescarga(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarDescarga(cosa){
		if (!cosas.contains(cosa)){
			self.error(cosa + " no esta cargada en el camion!")
		}
	}

	method todosTienenPesoPar(){
		return cosas.all({cosa => cosa.peso().even()})
	}

	method hayAlgunoQuePesa(_peso){
		return cosas.any({cosa => cosa.peso() == _peso})
	}

	method peso() {
		return tara + cosas.sum({cosa => cosa.peso()})
	}
	
	method estaExcedido(){
		return self.peso() > pesoMaximoAceptable
	}

	method elDeNivel(_nivel){
		return cosas.find({cosa => cosa.nivelPeligrosidad() == _nivel})
	}

	method cosasDePeligroSuperiorA(_nivel){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > _nivel})
	}

	method cosasMasPeligrosasQue(_cosa){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > _cosa.nivelPeligrosidad()})
	}

	method puedeCircularEnRuta(_nivelPeligro){
		return !self.estaExcedido() && self.cosasDePeligroSuperiorA(_nivelPeligro).isEmpty()
	}

	method hayAlgunoQuePesaEntre(_minimo, _maximo){
		return cosas.any({cosa => cosa.peso() >= _minimo && cosa.peso() <= _maximo })
	}

	method cosaMasPesada(){
		return cosas.max({cosa => cosa.peso()})
	}

	method todosLosPesos(){
		return cosas.map({cosa => cosa.peso()}) 
		// retorna lista de numeros en algun orden no especifico, transformacion conjunto a lista
	}

	method totalBultos(){
		return cosas.sum({cosa => cosa.bultos()})
	}

	method sufrirAccidente(){
		cosas.forEach({cosa => cosa.sufrirAccidente()})
	}
	method transportar(destino, camino){
		self.validarViaje(camino)
		destino.recibirCargo(cosas)
		cosas.forEach({cosa => self.descargar(cosa)})
	}

	method validarViaje(camino){
		if(!camino.puedeSorportarElViaje(self)){
			self.error("no puede soportar el viaje")
		}
	}

}

//tipo destino:

object almacen {
	const property inventario = #{}

	method recibirCargo(conjunto){
		inventario.addAll(conjunto)
	}
}

//tipo camino:

object ruta9{
	method puedeSorportarElViaje(transporte){
		return transporte.puedeCircularEnRuta(20)
	}
}

object caminosVecinales {
var property pesoSoportado = 0
	method puedeSorportarElViaje(transporte){
		return transporte.peso() < pesoSoportado
	}
}