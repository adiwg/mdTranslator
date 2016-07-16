
    function closeAllDetails(){
        var arr = document.getElementsByTagName("details");
        var len = arr.length;

        for(var i=0; i < len; i++){
            arr[i].open = false;
        }
    }

    function openAllDetails(){
        var arr = document.getElementsByTagName("details");
        var len = arr.length;

        for(var i=0; i < len; i++){
            arr[i].open = true;
        }
    }
