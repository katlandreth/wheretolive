// Initialize the map
function initMap(data, category) {
  data = JSON.parse(data);

  Highcharts.mapChart('container', {
    chart: {
      borderWidth: 1
    },

    colors: ['rgba(0,0,0,0.1)', "#6FCCEA","#63B8D3","#58A4BD","#4D90A6","#427D91","#386B7C","#2E5967","#244753","#1A3740","#11272E"],

    title: {
      text: 'Country by ' + category
    },

    mapNavigation: {
      enabled: true
    },

    legend: {
      title: {
        text: category + "<br> Best: 1 Worst: 100",
        style: {
          color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
        }
      },
      align: 'left',
      verticalAlign: 'bottom',
      floating: true,
      layout: 'vertical',
      valueDecimals: 0,
      backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || 'rgba(255, 255, 255, 0.85)',
      symbolRadius: 50,
      symbolHeight: 14,
    },
    tooltip: {
      formatter: function() {
        if (this.point.value == 0) {
          return '<b>' + this.point.name + '</b><br>' +
            "<b>No data for:</b><br>" + this.point.tooltip;
        } else {
          return '<b>' + this.series.name + '</b><br>' +
            this.point.name + ": " + this.point.value;
        }
      }
    },

    colorAxis: {
      dataClassColor: 'category',
      dataClasses: [{
        to: 0
      }, {
        from: 1.00,
        to: 10.99
      }, {
        from: 11.00,
        to: 20.99
      }, {
        from: 21.00,
        to: 30.99
      }, {
        from: 31.00,
        to: 40.99
      }, {
        from: 41.00,
        to: 50.99
      }, {
        from: 51.00,
        to: 60.99
      }, {
        from: 61.00,
        to: 70.99
      }, {
        from: 71.00,
        to: 80.99
      }, {
        from: 81.00,
        to: 90.99
      }, {
        from: 91.00,
        to: 100
      }]
    },

    series: [{
      data: data,
      mapData: Highcharts.maps['custom/world'],
      joinBy: ['iso-a2', 'code'],
      animation: false,
      name: category,
      states: {
        hover: {
          enabled:false
        }
      },
      tooltip: {
      }
    }]
  });
};
