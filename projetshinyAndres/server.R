library(shiny)
library(ggplot2)
function(input, output, session) {
  # Filtrage de la table selon les curseurs
  filtre <- reactive({
    filtres <- mtcars[mtcars$hp >= input$`curseur hp` & mtcars$qsec >= input$`curseur qsec`, c("hp", "qsec")]
    head(filtres, 10)
  })
  
  # Réactif pour la première voiture sélectionnée
  modeles <- reactive({
    req(input$modele)
    mtcars[input$modele, , drop = FALSE]
  })
  
  # Réactif pour la deuxième voiture sélectionnée
  modeles2 <- reactive({
    req(input$modele2)
    mtcars[input$modele2, , drop = FALSE]
  })
  
  # Affiche les détails de la première voiture sélectionnée
  output$detail <- renderTable({
    modeles()
  }, rownames = TRUE)
  
  # Affiche les détails de la deuxième voiture sélectionnée
  output$detail2 <- renderTable({
    modeles2()
  }, rownames = TRUE)
  
  # Salutation avec un input
  output$salutation <- renderText({
    paste0("Bonjour ", input$nom, ", comparons ensemble des voitures.")
  })
  
  # Tableau filtré en fonction des curseurs
  output$table <- renderTable({
    filtre()
  }, rownames = TRUE)
  # Graph du rapport poids/puissance des voitures
 output$bar_plot <- renderPlot({
  data <- mtcars
  data$rapport <- data$wt / data$hp  # Calcul du rapport poids/puissance
  ggplot(data, aes(x = reorder(rownames(data), rapport), y = rapport)) +
    geom_bar(stat = "identity", fill = "darkblue") +
    coord_flip() +
    labs(
      x = "Modèle de voiture",
      y = "Rapport Poids (wt) / Puissance (hp)",
      title = "Classement des voitures avec le meilleur rapport/puissance"
    ) +
    theme_minimal()
})
}