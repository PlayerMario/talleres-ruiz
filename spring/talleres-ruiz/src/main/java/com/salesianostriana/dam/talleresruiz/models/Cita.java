package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "cita")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Cita {

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mecanico_id", foreignKey = @ForeignKey(name = "FK_CITA_MECANICO"))
    private Mecanico mecanico;

    @ManyToOne
    @JoinColumn(name = "cliente_id", foreignKey = @ForeignKey(name = "FK_CITA_CLIENTE"))
    private Cliente cliente;

    @Column(name = "fecha_hora")
    private LocalDateTime fechaHora;

    private String estado;

    @Column(name = "img_vehiculo")
    @ElementCollection
    @Builder.Default
    private List<String> imgVehiculo = new ArrayList<>();

    @ElementCollection
    @Builder.Default
    private List<String> servicios = new ArrayList<>();

    @ElementCollection
    @Builder.Default
    private Map<String, String> comentarios = new HashMap<>();

    @JsonIgnore
    public static String hiddenFields = "id";

}
