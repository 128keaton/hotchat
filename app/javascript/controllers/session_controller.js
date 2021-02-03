import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
    static targets = ['form'];

    submitForm(event) {
        const errorStatus = this.validateForm(this.element);

        const tooLongError = $('.form-error-long');
        const tooShortError = $('.form-error-short');
        const invalidCharactersError = $('.form-error-invalid-characters');


        tooLongError.removeClass('form-error-show');
        tooShortError.removeClass('form-error-show');
        invalidCharactersError.removeClass('form-error-show');

        if (Object.values(errorStatus).find(e => e)) {
            // Error found
            event.preventDefault();

            if (errorStatus.invalidCharacters) {
                invalidCharactersError.addClass('form-error-show');
            }

            if (errorStatus.tooLong) {
                tooLongError.addClass('form-error-show');
            }

            if (errorStatus.tooShort) {
                tooShortError.addClass('form-error-show');
            }
        }
    }

    validateForm() {
        const invalidRegex = /[^\x20-\x7E]+/g;

        let tooLong = false;
        let tooShort = false;
        let invalidCharacters = false;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.element.querySelectorAll(requiredFieldSelectors);


        requiredFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();

                const matches = field.value.trim().match(invalidRegex);

                tooShort = field.value.trim().length < 5;
                tooLong = field.value.trim().length > 16;
                invalidCharacters = !!matches && matches.length > 0
            }
        });


        return {
            tooLong, tooShort, invalidCharacters
        };
    }
}