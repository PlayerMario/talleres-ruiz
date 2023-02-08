package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "mecanico")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Mecanico {

    @Id
    @GeneratedValue
    private Long id;

    private String dni;

    @Column(name = "nombre")
    private String nombreCompleto;

    //private User user;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    private String email;

    private String tlf;

    @JsonIgnore
    public static String hiddenFields = "id";

}
