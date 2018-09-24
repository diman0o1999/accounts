if (!window.Application)            { window.Application            = {}; }
if (!window.Application.Classes)    { window.Application.Classes    = {}; }

Application.Core = class Core {

    constructor() {
        this.afterRenderPage          = this.afterRenderPage.bind(this);
        this.bindClasses              = this.bindClasses.bind(this);
        this.initializeLazyModals     = this.initializeLazyModals.bind(this);
    }

    start() {
        return $(document).on('load turbolinks:load', this.afterRenderPage);
    }

    afterRenderPage() {
        this.bindClasses();
        this.initializeLazyModals();
    }

    bindClasses($parent) {
        if ($parent == null) { $parent = $('body'); }
        return $parent.find("[data-controller]").each((k, el) => {
            return $.each($(el).data("controller").split(" "), (index, className) => {
                if (!$(el).hasClass(className)) {
                    new (Application.Classes[className])($(el));
                    return $(el).addClass(className);
                }
            });
        });
    }
    initializeLazyModals($parent) {
        if ($parent == null) { $parent = $('body'); }
        return $parent.find('[data-lazy-modal]').each((k, el) => {
            const $el = $(el);
            return $el.off('click').on('click', event => {
                window.lazyModal = BootstrapDialog.show({
                    type: BootstrapDialog.TYPE_DEFAULT,
                    title: $el.data('lazy-modal-title'),
                    cssClass: $el.data('lazy-modal-css-class'),
                    draggable: true,
                    onshown: dialog => {
                        dialog.$modal.removeAttr('tabindex');
                        const $dialog = dialog.getModalBody();
                        return $dialog.load($(event.currentTarget).attr('href'), () => {
                           // this.initializeAllPlugins($dialog);
                            return this.bindClasses($dialog);
                        });
                    }
                });
                return false;
            });
        });
    }

};