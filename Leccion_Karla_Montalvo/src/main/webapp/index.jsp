<%-- 
    Document   : index
    Created on : 13 ene 2026, 3:38:53 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ejercicio 24 - Elecciones</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body { font-family: sans-serif; text-align: center; padding: 20px; }
            table { margin: 0 auto; border-collapse: collapse; width: 60%; }
            td, th { border: 1px solid #333; padding: 8px; }
            th { background-color: #f4f4f4; }
            .contenedor-grafico { width: 400px; margin: 20px auto; }
            .caja-formulario { 
                background-color: #FFCBE1;
                border: 2px solid #000000;
                padding: 20px; 
                display: inline-block; 
                border-radius: 10px; 
            }
            .btn-volver {
                display: inline-block; margin-top: 20px; padding: 10px 20px;
                background-color: #000000; color: white; text-decoration: none; border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <h1>Ejercicio 24: Resultados Electorales</h1>

        <%
            int v1 = 0, v2 = 0, v3 = 0, v4 = 0;
            int total = 0;
            double p1 = 0, p2 = 0, p3 = 0, p4 = 0;
            boolean mostrarResultados = false; 

            if (request.getParameter("partido1") != null) {
                try {
                    v1 = Integer.parseInt(request.getParameter("partido1"));
                    v2 = Integer.parseInt(request.getParameter("partido2"));
                    v3 = Integer.parseInt(request.getParameter("partido3"));
                    v4 = Integer.parseInt(request.getParameter("partido4"));

                    total = v1 + v2 + v3 + v4;

                    if (total > 0) {
                        p1 = (v1 * 100.0) / total;
                        p2 = (v2 * 100.0) / total;
                        p3 = (v3 * 100.0) / total;
                        p4 = (v4 * 100.0) / total;
                        mostrarResultados = true;
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: Ingrese solo números enteros.</p>");
                }
            }
        %>
        <% if (!mostrarResultados) { %>

            <div class="caja-formulario">
                <h3>Ingrese los votos</h3>
                <form action="index.jsp" method="post">
                    Partido A: <input type="number" name="partido1" required><br><br>
                    Partido B: <input type="number" name="partido2" required><br><br>
                    Partido C: <input type="number" name="partido3" required><br><br>
                    Partido D: <input type="number" name="partido4" required><br><br>
                    <input type="submit" value="Calcular y Graficar">
                </form>
            </div>

        <% } else { %>

            <div>
                <h2>Tabla de Resultados</h2>
                <table>
                    <tr>
                        <th>Partido</th>
                        <th>Votos</th>
                        <th>Porcentaje</th>
                    </tr>
                    <tr><td>Partido A</td> <td><%= v1 %></td> <td><%= String.format("%.2f", p1) %> %</td></tr>
                    <tr><td>Partido B</td> <td><%= v2 %></td> <td><%= String.format("%.2f", p2) %> %</td></tr>
                    <tr><td>Partido C</td> <td><%= v3 %></td> <td><%= String.format("%.2f", p3) %> %</td></tr>
                    <tr><td>Partido D</td> <td><%= v4 %></td> <td><%= String.format("%.2f", p4) %> %</td></tr>
                    <tr><td><strong>TOTAL</strong></td> <td><strong><%= total %></strong></td> <td>100%</td></tr>
                </table>

                <div class="contenedor-grafico">
                    <canvas id="graficoVotos"></canvas>
                </div>

                <a href="index.jsp" class="btn-volver">Volver a calcular</a>
            </div>

            <script>
                var ctx = document.getElementById('graficoVotos').getContext('2d');
                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: ['Partido A', 'Partido B', 'Partido C', 'Partido D'],
                        datasets: [{
                            data: [<%= v1 %>, <%= v2 %>, <%= v3 %>, <%= v4 %>],
                            backgroundColor: [
                                '#FFCAE9', 
                                '#FB9EBB', 
                                '#DCCCEC',
                                '#BCD8EC'  
                            ]
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: { position: 'bottom' },
                            title: { display: true, text: 'Distribución de Votos' }
                        }
                    }
                });
            </script>

        <% } %>

    </body>
</html>
