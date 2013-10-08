<?php
Asse::addCss('jquery.jqplot.min.css', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('jquery.jqplot.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('plugins/jqplot.canvasTextRenderer.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('plugins/jqplot.highlighter.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('plugins/jqplot.cursor.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('plugins/jqplot.bubbleRenderer.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));
Asse::addJs('plugins/jqplot.canvasAxisLabelRenderer.min.js', Yii::getPathOfAlias('webroot.web.jqplot'));

?>

<script type="text/javascript">
    $(document).ready(function () {
        // Some simple loops to build up data arrays.
        var profilePoints = [
            <?php
                foreach($result as $res){
                    if(!empty($res['profiles'])){
                        $point = new LocationPoint($res['scale_cxy']);
                        echo "[{$point->cx},{$point->cy},".count($res['profiles']).",'{$res['real_cxyxy']}'],";
                    }
                }
            ?>
        ];
        var spiritsPoints = [
            <?php
                foreach($result as $res){
                    if(!empty($res['spirits'])){
                        $point = new LocationPoint($res['scale_cxy']);
                        echo "[{$point->cx},{$point->cy},".count($res['spirits']).",'{$res['real_cxyxy']}'],";
                    }
                }
            ?>
        ];



        var plot = $.jqplot('plot', [profilePoints, spiritsPoints],
            {
                title: 'Profiles and Spirits',
                axes:{
                    xaxis:{
                        renderer:$.jqplot.DateAxisRenderer,
                        tickOptions:{
                            formatString:'%d'
                        }
                    },
                    yaxis:{
                        'autoscale': false,
                        tickOptions:{
                            formatString:'%d'
                        }
                    }
                },
                highlighter: {
                    show: true,
                    sizeAdjust: 7.5
                },
                cursor: {
                    show: false
                },
                // Series options are specified as an array of objects, one object
                // for each series.
                series: [
                    {
                        showLine: false,
                        markerOptions: { style: "filledSquare", size: 10 }
                    },
                    {
                        // Don't show a line, just show markers.
                        // Make the markers 7 pixels with an 'x' style
                        showLine: false,
                        markerOptions: { size: 10, style: "x" }
                    },
                ]
            }
        );

    });
</script>
<div id="plot"></div>