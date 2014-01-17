$(document).ready(function () {
    $('.big_tiny').tinymce({
        theme: "modern",
        plugins: [
            "advlist autolink lists link image charmap print preview hr anchor pagebreak",
            "searchreplace wordcount visualblocks visualchars code fullscreen",
            "insertdatetime media nonbreaking save table contextmenu directionality",
            "emoticons template paste textcolor"
        ],
        toolbar1: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | preview code  | forecolor backcolor | link image media",
        toolbar2: "",
        image_advtab: true ,
        toolbar_items_size: 'small',
        relative_urls: false,
        external_filemanager_path:"/web/responsive_filemanager/filemanager/",
        filemanager_title:"Responsive Filemanager" ,
        external_plugins: { "filemanager" : "/web/responsive_filemanager/filemanager/plugin.min.js"},
        fontsize_formats: "8px 10px 12px 14px 18px 24px 36px"/*,
        language : 'ru'*/

    });
});
