import { debounce } from 'debounced'
import ApplicationController from './application_controller'

const reload = controller => {
  controller.stimulate('GameReflex#default_reflex')
}
const debouncedReload = debounce(reload, { wait: 100 })

/* This is the custom StimulusReflex controller for the Game Reflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  /*
   * Regular Stimulus lifecycle methods
   * Learn more at: https://stimulusjs.org/reference/lifecycle-callbacks
   *
   * If you intend to use this controller as a regular stimulus controller as well,
   * make sure any Stimulus lifecycle methods overridden in ApplicationController call super.
   *
   * Important:
   * By default, StimulusReflex overrides the -connect- method so make sure you
   * call super if you intend to do anything else when this controller connects.
  */

  connect () {
    super.connect()
    // add your code here, if applicable
  }
  
  reload (event) {
    console.log("is this even firing")
    debouncedReload(this)
  }
}
