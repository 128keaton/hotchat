import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
    static targets = ['form'];

    submitForm(event) {
        let lengthValid = this.validateForm(this.element);
        let unicodeValid = this.checkUnicode(this.element);
        let lengthError = $('.form-error-length');
        let unicodeError = $('.form-error-unicode');


        lengthError.removeClass('form-error-show');
        unicodeError.removeClass('form-error-show');

        if (!lengthValid) {
            event.preventDefault();
            lengthError.addClass('form-error-show');
            return;
        }


        if (!unicodeValid) {
            event.preventDefault();
            unicodeError.addClass('form-error-show');
        }
    }

    validateForm() {
        let isValid = true;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();
                isValid = field.value.trim().length > 5;
            }
        });


        return isValid;
    }

    checkUnicode() {
        const nonASCIIRegex = /[^\x20-\x7E]+/g;

        let noUnicode = true;
        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();

                const matches = field.value.trim().match(nonASCIIRegex);

                if (!!matches && matches.length > 0) {
                    noUnicode = false;
                }
            }
        });

        return noUnicode;
    }
}