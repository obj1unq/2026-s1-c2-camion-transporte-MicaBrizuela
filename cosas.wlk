// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
// cosas.wlk
object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultos(){ return 1}
	method sufrirAccidente(){}
}

object arenaAGranel{
	var peso = 0
	method peso(_peso) {
	  peso = _peso
	}
	method peso() { return peso }
	method nivelPeligrosidad(){ return 1}
	method bultos(){ return 1}
	method sufrirAccidente(){
		peso += 20
	}
}

object bumblebee{
	var esAuto = true
	method peso() { return 800}
	method nivelPeligrosidad(){ return if (esAuto) {15} else {30} }
	method transformarEnRobot(){
		esAuto = false
	}
	method transformarEnAuto() {
	  esAuto = true
	}
	method bultos(){ return 2}
	method sufrirAccidente(){
		esAuto.negate()
	}
}

object paqueteDeLadrillos{
	var property cantidadDeLadrillos = 0
	method peso() {return 2 * cantidadDeLadrillos}
	method nivelPeligrosidad(){return 2}
	method bultos(){ 
		return if (cantidadDeLadrillos > 300) {3} else {
			if (cantidadDeLadrillos > 100) {2} else {1} 
		}
	}
	method sufrirAccidente(){
		if (cantidadDeLadrillos <= 12) {
			cantidadDeLadrillos = 0
		} else{
			cantidadDeLadrillos -= 12
		}
	}
}

object bateriaAntiaerea{
	var hayMisiles = false
	method peso() {return if (hayMisiles) {300} else {200}}
	method nivelPeligrosidad(){ return if (hayMisiles) {100} else {0}}
	method agregarMisiles(){
		hayMisiles = true
	}
	method bultos(){ return if (hayMisiles) {2} else {1}}
	method sufrirAccidente(){
		hayMisiles = false
	}
}

object residuosRadioactivos{
	var peso = 0
	method peso() { return peso}
	method nivelPeligrosidad(){return 200}
	method peso(_peso){
		peso = _peso
	}
	method bultos(){ return 1}
	method sufrirAccidente(){ peso += 15}
}

object contenedorPortuario{
	const cosas = #{}
	method peso() { return 100 + cosas.sum({cosa => cosa.peso()})}
	method nivelPeligrosidad(){
		return if (cosas.isEmpty()) {0} else {self.cosaMasPeligrosa().nivelPeligrosidad()}}
	method agregarCosas(_conjunto){
		cosas.addAll(_conjunto)
	}
	method cosaMasPeligrosa(){
		return cosas.max({cosa => cosa.nivelPeligrosidad()})
	}
	method cosas(){
		return cosas
	}
	method bultos(){ return 1 + cosas.sum({cosa => cosa.bultos()})}
	method sufrirAccidente(){
		cosas.forEach({cosa => cosa.sufrirAccidente()})
	}

}

object embalajeDeSeguridad{
	var cosa = null
	method peso() {return cosa.peso()}
	method nivelPeligrosidad(){return cosa.nivelPeligrosidad()/2}
	method embalar(_cosa){
		cosa = _cosa
	}
	method bultos(){ return 2}
	method sufrirAccidente(){}
}
