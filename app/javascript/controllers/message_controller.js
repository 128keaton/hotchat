import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {

    connect() {
        console.log(this.element);
        setTimeout(() => {
            $(this.element).addClass('show');
        }, 100);
    }
}