package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mensaje")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Mensaje {

    @Id
    @GeneratedValue
    private Long id;

    @Lob
    private String mensaje;

    @ManyToOne
    private Cita cita;

    @ManyToOne
    @CreatedBy
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_MENSAJE_USER"))
    private User autor;

    @Builder.Default
    @Column(name = "fecha_hora")
    private LocalDateTime fechaHora = LocalDateTime.now();

    @JsonIgnore
    public static String hiddenFields = "id";


    // HELPERS MENSAJE-CITA
    public void agregarCita(Cita cita) {
        this.cita = cita;
        cita.getChat().add(this);
    }

    public void removeCita(Cita cita) {
        this.cita = null;
        cita.getChat().remove(this);
    }

}
