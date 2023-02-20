package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "adjunto")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Adjunto {

    @Id
    @GeneratedValue
    private Long id;

    //@Lob
    private String contenido;

    @ManyToOne
    @JoinColumn(name = "cita_id", foreignKey = @ForeignKey(name = "FK_ADJUNTO_CITA"))
    private Cita cita;

    @ManyToOne
    @CreatedBy
    @JoinColumn(name = "user_id", foreignKey = @ForeignKey(name = "FK_ADJUNTO_USER"))
    private User autor;

    @Builder.Default
    @Column(name = "fecha_hora")
    @JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    private LocalDateTime fechaHora = LocalDateTime.now();

    private boolean fichero;

    @JsonIgnore
    public static String hiddenFields = "id";


    // CONSTRUCTOR
    public Adjunto(String contenido, Cita cita, User autor, boolean fichero) {
        this.contenido = contenido;
        this.cita = cita;
        this.autor = autor;
        this.fichero = fichero;
    }


    // HELPERS MENSAJE-CITA
    public void agregarCita(Cita cita) {
        this.cita = cita;
        cita.getChat().add(this);
    }

    public void borrarCita(Cita cita) {
        this.cita = null;
        cita.getChat().remove(this);
    }

}
