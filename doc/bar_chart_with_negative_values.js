var chart = AmCharts.makeChart("chartdiv", {
  "type": "serial",
  "theme": "light",
  "rotate": true,
  "marginBottom": 50,
  "dataProvider": [{
    "Industry": "MGS",
    "male": -0.330,
    "female": 0.381
  }, {
    "Industry": "BUS",
    "male": -0.360,
    "female": 0.392
  }, {
    "Industry": "FIN",
    "male": -0.247,
    "female": 0.337
  }, {
    "Industry": "CMM",
    "male": -0.266,
    "female": 0.383
  }, {
    "Industry": "ENG",
    "male": -0.362,
    "female": 0.483
  }, {
    "Industry": "SCI",
    "male": -0.309,
    "female": 0.396
  }, {
    "Industry": "CMS",
    "male": -0.279,
    "female": 0.282
  }, {
    "Industry": "LGL",
    "male": -0.272,
    "female": 0.329
  }, {
    "Industry": "EDU",
    "male": -0.336,
    "female": 0.338
  }, {
    "Industry": "ENT",
    "male": -0.370,
    "female": 0.586
  }, {
    "Industry": "MED",
    "male": -0.272,
    "female": 0.243
  }, {
    "Industry": "HLS",
    "male": -0.266,
    "female": 0.370
  }, {
    "Industry": "PRT",
    "male": -0.374,
    "female": 0.434
  }, {
    "Industry": "EAT",
    "male": -0.268,
    "female": 0.400
  }, {
    "Industry": "CLN",
    "male": -0.286,
    "female": 0.353
  }, {
    "Industry": "PRS",
    "male": -0.306,
    "female": 0.395
  }, {
    "Industry": "SAL",
    "male": -0.252,
    "female": 0.398
  },{
    "Industry": "OFF",
    "male": -0.361,
    "female": 0.416
  },{
    "Industry": "FFF",
    "male": -0.373,
    "female": 0.417
  },{
    "Industry": "CON",
    "male": -0.382,
    "female": 0.396
  },{
    "Industry": "EXT",
    "male": -0.370,
    "female": 0.503
  },{
    "Industry": "RPR",
    "male": -0.384,
    "female": 0.478
  }, {
    "Industry": "PRD",
    "male": -0.347,
    "female": 0.418
  }, {
    "Industry": "TRN",
    "male": -0.272,
    "female": 0.297
  },{
    "Industry": "MIL",
    "male": -0.405,
    "female": 0.450
  }],
  "startDuration": 1,
  "graphs": [{
    "fillAlphas": 0.8,
    "lineAlpha": 0.2,
    "type": "column",
    "valueField": "male",
    "title": "Male",
    "labelText": "[[value]]",
    "clustered": false,
    "labelFunction": function(item) {
      return Math.abs(item.values.value);
    },
    "balloonFunction": function(item) {
      return item.category + ": " + Math.abs(item.values.value);
    }
  }, {
    "fillAlphas": 0.8,
    "lineAlpha": 0.2,
    "type": "column",
    "valueField": "female",
    "title": "Female",
    "labelText": "[[value]]",
    "clustered": false,
    "labelFunction": function(item) {
      return Math.abs(item.values.value);
    },
    "balloonFunction": function(item) {
      return item.category + ": " + Math.abs(item.values.value);
    }
  }],
  "categoryField": "Industry",
  "categoryAxis": {
    "gridPosition": "start",
    "gridAlpha": 0.2,
    "axisAlpha": 0
  },
  "valueAxes": [{
    "gridAlpha": 0,
    "ignoreAxisWidth": true,
    "labelFunction": function(value) {
      return Math.abs(value)*100 + "%";
    },
    "guides": [{
      "value": 0,
      "lineAlpha": 0.2
    }]
  }],
  "balloon": {
    "fixedPosition": true
  },
  "chartCursor": {
    "valueBalloonsEnabled": true,
    "cursorAlpha": 0.05,
    "fullWidth": true
  },
  "allLabels": [{
    "text": "Male",
    "x": "25%",
    "y": "95%",
    "bold": true,
    "align": "middle"
  }, {
    "text": "Female",
    "x": "75%",
    "y": "95%",
    "bold": true,
    "align": "middle"
  }],
 "export": {
    "enabled": true
  }

});