package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "cliente")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
@NamedEntityGraph(
        name = "cliente-con-citas",
        attributeNodes = {
                @NamedAttributeNode(value = "citas")
        }
)
public class Cliente {

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

    @OneToMany(mappedBy = "cliente", fetch = FetchType.LAZY)
    @Builder.Default
    private List<Cita> citas = new ArrayList<>();

    private String vehiculo;

    private String matricula;

    @JsonIgnore
    public static String hiddenFields = "id";


    // HELPERS CLIENTE-CITA
    public void agregarCita(Cita cita) {
        cita.setCliente(this);
        citas.add(cita);
    }

    public void borrarCita(Cita cita) {
        this.citas.remove(cita);
        cita.setCliente(null);
    }

    // MÉTODOS AUXILIARES
    @PreRemove
    public void setNullCitas() {
        citas.forEach(cita -> {
            cita.setCliente(null);
        });
    }

}
