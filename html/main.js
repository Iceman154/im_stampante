$(function () {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.tipo === "ui") {
            if (item.stato == true) {
                $(".stampante").fadeIn();
            } else {
                $(".stampante").fadeOut();
            }
        } else if (item.tipo === "foto") {
            if (item.stato == true) {
                var img = new Image();
                img.src = item.link
                img.onload = function() {
                    $('.foto').css('background-image', 'url('+item.link+')');
                    $('.foto').css('width', this.width);
                    $('.foto').css('height', this.height);
                }
                $(".foto").fadeIn(); 
            } else {
                $(".foto").fadeOut();
            }
        }
    })

    $(".invio").click(function(){
        if ($(".link").val() !== '') {
            $.post('http://im_stampante/azioni', JSON.stringify({
                azione : 'stampa',
                link : $(".link").val(),
            }));
            $(".stampante").fadeOut();
            return
        } else {
            $.post('http://im_stampante/azioni', JSON.stringify({
                azione : 'niente_link',
            }));
            return
        }	
	});

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://im_stampante/azioni', JSON.stringify({
                azione : 'chiudi',
            }));
            return
        }
    };
})