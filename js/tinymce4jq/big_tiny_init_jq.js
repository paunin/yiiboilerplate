$(document).ready(function () {
    $('.big_tiny').tinymce({
        theme: "modern",
        plugins: [
            "advlist autolink lists link image charmap print preview hr anchor pagebreak",
            "searchreplace wordcount visualblocks visualchars code fullscreen",
            "insertdatetime media nonbreaking save table contextmenu directionality",
            "emoticons template paste textcolor"
        ],
        toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
        toolbar2: "print preview code media | forecolor backcolor emoticons",
        image_advtab: true ,
        external_filemanager_path:"/web/responsive_filemanager/filemanager/",
        filemanager_title:"Responsive Filemanager" ,
        external_plugins: { "filemanager" : "/web/responsive_filemanager/filemanager/plugin.min.js"},
        fontsize_formats: "8px 10px 12px 14px 18px 24px 36px"

    });
});
