package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "cita")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
@NamedEntityGraph(
        name = "cita-con-chat",
        attributeNodes = {
                @NamedAttributeNode(value = "chat")
        }
)
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

    @JsonFormat(pattern = "dd-MM-yyyy HH:mm")
    private LocalDateTime fechaHora;

    private String estado;

    @OneToMany(mappedBy = "cita", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<Adjunto> chat = new ArrayList<>();

    @JsonIgnore
    public static String hiddenFields = "id";


    // CONSTRUCTORES
    public Cita(Mecanico mecanico, Cliente cliente, LocalDateTime fechaHora, String estado) {
        this.mecanico = mecanico;
        this.cliente = cliente;
        this.fechaHora = fechaHora;
        this.estado = estado;
    }


    // HELPERS CITA-CLIENTE
    public void agregarCliente(Cliente cliente) {
        this.cliente = cliente;
        cliente.getCitas().add(this);
    }

    public void borrarCliente(Cliente cliente) {
        this.cliente = null;
        cliente.getCitas().remove(this);
    }


    // MÉTODOS AUXILIARES
    @PreRemove
    public void setNullCitas() {
        chat.forEach(chat -> {
            chat.setCita(null);
        });
    }

}
