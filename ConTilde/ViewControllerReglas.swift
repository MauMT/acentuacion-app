//
//  ViewControllerReglas.swift
//  ConTilde
//
//  Created by user189095 on 4/20/21.
//

import UIKit

class ViewControllerReglas: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    @IBOutlet weak var reglaButton: UIButton!
    @IBOutlet weak var diptongoHiato: UIButton!
    @IBOutlet weak var casosEspeciales: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reglaButton.layer.cornerRadius = 10.0
        diptongoHiato.layer.cornerRadius = 10.0
        casosEspeciales.layer.cornerRadius = 10.0
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "general" {
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "Regla General"
            viewGeneral.textoLargo = "Las palabras pueden ser agudas, llanas (también llamadas graves), esdrújulas o sobreesdrújulas. Una palabra aguda es aquella en la que la sílaba tónica, aquella cuyo sonido es más prominente, recae en la última sílaba.\n\nEn una palabra grave la sílaba tónica recae en la penúltima sílaba; mientras que, en las palabras esdrújulas y sobreesdrújulas la sílaba tónica es la antepenúltima y anterior a la antepenúltima de la palabra.\n\nLas palabras agudas (no monosílabas) se acentúan si terminan en vocal, ‘n’ o ‘s’.\n\tdialogó, inglés, andén.\n\nLas palabras llanas se acentúan si no terminan en vocal, ene o ese.\n\tfácil, cárcel, lápiz.  \n\nLas palabras esdrújulas y sobresdrújulas se acentúan todas:\n\tdiálogo, médico, cómetelo."
        }
        else if segue.identifier == "diptongo" {
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "Diptongo y Hiato"
            viewGeneral.textoLargo = "Existe un diptongo si hay una secuencia de dos vocales diferentes que van en una sola sílaba.\n\nLos diptongos NO se separan.\n\nVocal cerrada (i, u) + Vocal cerrada (i, u)\n\ttriunfar, ciudad, viudo\n\nVocal abierta (a, e, o) + Vocal cerrada (i, u) (Si la cerrada no es tónica)\n\taire, auto, jaula\n\nVocal cerrada (i, u) + Vocal abierta (a, e, o) (Si la cerrada no es tónica)\n\tviaje, nieve, viento\n\nExiste un hiato si hay una secuencia de dos vocales que se pronuncian en sílabas distintas.\n\nLos hiatos se separan.\n\nVocal abierta (a, e, o) + Vocal abierta (a, e, o)\n\tcaer, cacao, teatro\n\nVocal abierta (a, e, o) + Vocal cerrada tónica (í, ú)\n\traíz, país, baúl\n\nVocal cerrada tónica (í, ú) + Vocal abierta (a, e, o)\n\ttenía, sandía, frío\n\nLa letra H intercalada entre dos vocales no interfiere en la formación de un diptongo o un hiato.\n\nPara que una palabra lleve acento en contradicción con las reglas generales en necesario (y suficiente) que se cumplan las tres condiciones siguientes:\n\t•Que la vocal tónica sea una i o una u\n\t•Que vaya precedida o seguida de una vocal fuerte (a, e, o)\n\t•Que ambas vocales pertenezcan a sílabas distintas\n\nEjemplos: había, país, lío, sonreír, baúl, aíslo, actúa, judaísmo, pero hinduismo, ruin, etc."

        }else{
            let viewGeneral = segue.destination as! ViewControllerMuestraReglas
            
            viewGeneral.titulo = "Casos Especiales"
            viewGeneral.textoLargo = "Existen palabras que pueden ser escritas con o sin tilde dependiendo del contexto de la oración.\n\nAlgunas de ellas, principalmente monosílabas, requieren ser acentuadas para distinguir su significado.\n\nEjemplos de uso del acento diacrítico:\nel (artículo),\tél (pronombre personal)\ncomo (conjunción, primera persona singular de comer),\tcómo (pronombre interrogativo)\nsi (sustantivo o conjunción),\tsí (adverbio de afirmación, pronombre personal)\nmi (adjetivo posesivo),\tmí (pronombre personal)\nse (pronombre personal),\tsé (1ra persona singular de saber)\nmas (conjunción),\tmás (adverbio de cantidad)\ntu (adjetivo posesivo),\ttú (pronombre personal)\n\nEjemplos en los que la acentuación de la palabra depende del contexto:\n•El profesor solo lo conoce a él.\n•¿Cómo lo lograste? Te has vuelto tan bueno como yo.\nSi hubieras asistido a esa clase, sí sabrías resolver el ejercicio.\n•A mí no me importa si mi ropa está planchada o no.\n•Por lo que sé, la familia de al lado se mudará.\n•Ella quiere viajar a Austria, mas no tiene dinero. Necesita ahorrar más.\n•¿Tú ya hiciste tu tarea?"
        }
    }
    
}
