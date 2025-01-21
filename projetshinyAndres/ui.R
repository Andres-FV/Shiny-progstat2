library(shiny)
library(ggplot2)
library(shinythemes)
navbarPage(
  "Comparateur de voitures",
  theme=shinytheme("flatly"),
  tabPanel(
    "Accueil",
    fluidPage(
      titlePanel("Bienvenue dans le comparateur de voitures"),
      sidebarLayout(
        sidebarPanel(
          strong(h1("Vos options de comparaison")),
          h3(textInput("nom", "Quel est votre nom ?"),
             textOutput("salutation")),
          img(src = "voiture1.png", height = "300px", width = "500px", alt = "Image d'une voiture") ),
        mainPanel(
          h4("Instructions :"),
          p("1. Rendez-vous dans l'onglet 'Comparaison de voitures' pour sélectionner et comparer deux voitures."),
          p("2. Rendez-vous dans l'onglet 'Vos voitures idéals' pour voire 10 voitures correspondante a vos envie de performance."),
          p("3. Utilisez les curseurs pour filtrer les voitures selon le temps en secondes pour parcourir un quart de miles et la puissance de la voiture en chevaux."),
          p("4. Rendez-vous dans l'onglet 'Nos modéles les plus performants' pour voire quelles sont nos voitures avec le meilleur rapport poids puisance.")
        )
      )
    )
  ),
  
  tabPanel(
    "comparaison de voitures",
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          h3("Choisissez vos modèles :"),
          selectInput("modele", "Modèles", choices = rownames(mtcars)),
          selectInput("modele2", "Modèles2", choices = rownames(mtcars)),
          h4("Légende des colonnes :"),
          p(
            " - **mpg** : Miles par gallon (consommation de carburant).",
            br(),
            " - **cyl** : Nombre de cylindres.",
            br(),
            " - **disp** : Cylindrée, en pouces cubes.",
            br(),
            " - **hp** : Puissance en chevaux (horsepower).",
            br(),
            " - **drat** : Ratio de transmission.",
            br(),
            " - **wt** : Poids (en milliers de livres).",
            br(),
            " - **qsec** : Temps pour parcourir 1/4 de mile (accélération).",
            br(),
            " - **vs** : Type de moteur (V ou en ligne).",
            br(),
            " - **am** : Transmission (automatique ou manuelle).",
            br(),
            " - **gear** : Nombre de vitesses.",
            br(),
            " - **carb** : Nombre de carburateurs."
          )
        ),
        mainPanel(
          h4("Détails de la première voiture sélectionnée :"),
          tableOutput("detail"),
          h4("Détails de la deuxième voiture sélectionnée :"),
          tableOutput("detail2")
        )
      )
    )
  ),
  
  tabPanel(
    "Vos voitures idéals",
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          h3("Ajustez les curseurs pour filtrer les voitures :"),
          sliderInput("curseur hp", label = "Puissance minimale (hp)", 
                      min = min(mtcars$hp), max = max(mtcars$hp), value = min(mtcars$hp)),
          sliderInput("curseur qsec", label = "Temps minimal pour 1/4 de mile (qsec)", 
                      min = min(mtcars$qsec), max = max(mtcars$qsec), value = min(mtcars$qsec))
          
        ),
        mainPanel(
          h4("Voitures filtrées par vos curseurs :"),
          tableOutput("table"),
          
        )
      )
    )
  ),
  tabPanel(
    "Nos modéles les plus performants",
    fluidPage(
      titlePanel("Graphique du rapport Poids/Puissance"),
      mainPanel(
        h4("Barres représentant le rapport Poids (wt) / Puissance (hp) :"),
        plotOutput("bar_plot", height = "500px"),
        
      )
    )
  )
)