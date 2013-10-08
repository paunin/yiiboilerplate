<?php

Asse::addJs('jquery.flot.js', Yii::getPathOfAlias('webroot.web.flot'));
Asse::addJs('jquery.flot.navigate.js', Yii::getPathOfAlias('webroot.web.flot'));
Asse::addJs('jquery.flot.symbol.js', Yii::getPathOfAlias('webroot.web.flot'));


?>
<b>In js varible `apiResult` you can found result of real api method</b><br/><br/><br/>
<script type="text/javascript">
    Object.size = function (obj) {
        var size = 0, key;
        for (key in obj) {
            if (obj.hasOwnProperty(key)) size++;
        }
        return size;
    };



    var apiResult = <?php echo json_encode($result) ?>;

    var getPointInfo = function (x, y) {
        var spirits = [],
        profiles = [];

        $.each(apiResult["" + x + ":" + y]['spirits'], function (point, arr) {
            var profs = [];
            $.each(arr, function (point, profile){
                profs.push(profile.id +'-'+ profile.username)
            });
            spirits.push(point + " => " + profs.join(', '))
        })


        $.each(apiResult["" + x + ":" + y]['profiles'], function (point, arr) {
            var profs = [];
            $.each(arr, function (point, profile){
                profs.push(profile.id +'-'+ profile.username)
            });
            profiles.push(point + " => " + profs.join(', '))
        })


        return x + ":" + y + "<br/>" +
            "real_cxyxy: " + apiResult["" + x + ":" + y]['real_cxyxy'] + "<br/>" +
            "<b>profiles:</b><br/> " + /*Object.size(apiResult["" + x + ":" + y]['spirits']) +*/ "" + profiles.join('<br/>') + "" + "<br/>" +
            "<b>spirits:</b><br/> " + /*Object.size(apiResult["" + x + ":" + y]['profiles']) +*/ "" + spirits.join('<br/>') + "" + "<br/>" +
            ""
    }



    $(function () {

        var profilePoints = [
            <?php
                foreach($result as $res){
                    if(!empty($res['profiles'])){
                        $point = new LocationPoint($res['scale_cxy']);
                        echo "[{$point->cx},{$point->cy}],";
                    }
                }
            ?>
        ];


        var spiritsPoints = [
            <?php
                foreach($result as $res){
                    if(!empty($res['spirits'])){
                        $point = new LocationPoint($res['scale_cxy']);
                        echo "[{$point->cx},{$point->cy}],";
                    }
                }
            ?>
        ];

        var data = [
            {
                "data": profilePoints,
                "color": '#c99b12',
                points: { symbol: "square"}
            },
            {
                "data": spiritsPoints,
                "color": '#069b08',
                points: { symbol: "cross"}
            }
        ];
        var placeholder = $("#plot");

        var plot = $.plot(placeholder, data, {
            series: {
                points: { show: true, radius: 5},
                lines: { show: false, fill: false },
                shadowSize: 0
            },
            grid: {
                hoverable: true,
                clickable: true
            },
            xaxis: {
                position: "top",
                zoomRange: [1, 10000000],
                panRange: [0, 10000000]
            },
            yaxis: {
                zoomRange: [1, 10000000],
                panRange: [-10000000, 0]
            },
            zoom: {
                interactive: true
            },
            pan: {
                interactive: true
            }
        });

        function showTooltip(x, y, contents) {

            $("<div id='tooltip'>" + contents + "</div>").css({
                position: "absolute",
                display: "none",
                top: y + 20,
                left: x + 20,
                border: "1px solid #fdd",
                padding: "2px",
                "background-color": "#fee",
                opacity: 0.80
            }).appendTo("body").fadeIn(200);
        }

        var previousPoint = null;
        $("#plot").bind("plothover", function (event, pos, item) {


            if (item) {
                if (previousPoint != item.dataIndex) {

                    previousPoint = item.dataIndex;

                    $("#tooltip").remove();
                    var x = item.datapoint[0],
                        y = item.datapoint[1];

                    showTooltip(item.pageX, item.pageY,
                        getPointInfo(x, y)
                    );
                }
            } else {
                $("#tooltip").remove();
                previousPoint = null;
            }

        });
    });

</script>
<div id="plot" style="width: 870px; height: 870px;"></div>
<div id="plotpan"></div>