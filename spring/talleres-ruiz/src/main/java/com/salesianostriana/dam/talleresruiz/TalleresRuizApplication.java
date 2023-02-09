package com.salesianostriana.dam.talleresruiz;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.info.License;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@OpenAPIDefinition(info =
@Info(
        description = "API de gestión de citas de un taller de automoción.",
        version = "1.0",
        contact = @Contact(email = "ruiz.lomar22@triana.salesianos.edu", name = "Mario Ruiz"),
        title = "Talleres-Ruiz API",
        license = @License(name = "Licencia de Talleres-Ruiz")
)
)
//@EnableJpaAuditing
public class TalleresRuizApplication {

    public static void main(String[] args) {
        SpringApplication.run(TalleresRuizApplication.class, args);
    }

}
