import {Controller} from "stimulus"
import $ from "jquery"

export default class extends Controller {
    reset() {
        this.element.reset();
        $(this.element).find(':submit').removeAttr('disabled');
    }
}