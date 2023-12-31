document.addEventListener('DOMContentLoaded', function() {

    var statusCanvas = document.getElementById('status-canvas').getContext('2d');
    
    var borderColorOk = 'rgb(44, 161, 100)';
    var borderColorAlerta = 'rgb(255, 215, 0)'; 
    var borderColorCritico = 'rgb(255, 99, 71)';
    var borderColorOff = 'gray';
    
    var statusData = {
        labels: ['Desligado', 'Critico', 'Alerta', 'Ok'],
        datasets: [{
            data: [20, 2, 8, 70],
            backgroundColor: ['rgb(101, 101, 101)','rgba(255, 99, 71, 0.7)', 'rgba(255, 215, 0, 0.7)' ,'rgb(44, 161, 100)'],
            borderColor: [borderColorOff, borderColorCritico, borderColorAlerta, borderColorOk], 
            borderWidth: 2, 
        }]
    };
    
    var statusChart = new Chart(statusCanvas, {
        type: 'doughnut',
        data: statusData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            var label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += context.formattedValue + '% dos totens';
                            return label;
                        }
                    }
                }
            },
            cutout: '80%'
        }
    });

    var totalTotems = statusData.datasets[0].data.reduce((total, value) => total + value - 22.5, 0);

    var totalTotemsText = document.createElement('div');
    totalTotemsText.classList.add('total-totems-text');
    totalTotemsText.textContent = `${totalTotems} Totens sendo monitorados`;
    
    document.getElementById('status-canvas').parentNode.appendChild(totalTotemsText);

});