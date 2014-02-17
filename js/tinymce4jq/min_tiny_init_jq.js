$(document).ready(function () {
    $('.min_tiny').tinymce({
        theme: "modern",
        plugins: [
            "advlist autolink lists link image charmap print preview hr anchor pagebreak",
            "searchreplace wordcount visualblocks visualchars code fullscreen",
            "insertdatetime media nonbreaking save table contextmenu directionality",
            "emoticons template paste textcolor"
        ],
        menubar: false,
        toolbar_items_size: 'small',
        toolbar1: "bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | forecolor backcolor | link image media ",
        toolbar2: "",
        image_advtab: true ,
        relative_urls: false,
        image_advtab: true ,
        relative_urls: false,
        external_filemanager_path:"/web/responsive_filemanager/filemanager/",
        filemanager_title:"Responsive Filemanager" ,
        external_plugins: { "filemanager" : "/web/responsive_filemanager/filemanager/plugin.min.js"}/*,
        language : 'ru'*/
    });
});
