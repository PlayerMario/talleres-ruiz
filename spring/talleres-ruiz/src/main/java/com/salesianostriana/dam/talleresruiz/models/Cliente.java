package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.*;
import org.hibernate.annotations.NaturalId;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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
    private UUID id;

    @MapsId
    @JsonIgnore
    @JoinColumn(name = "user_entity_id", foreignKey = @ForeignKey(name = "FK_CLIENTE_USER"), columnDefinition = "uuid")
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private User usuario;

    @OneToMany(mappedBy = "cliente", fetch = FetchType.LAZY)
    @Builder.Default
    private List<Cita> citas = new ArrayList<>();

    private String vehiculo;

    private String matricula;

    @JsonIgnore
    public static String hiddenFields = "id";


    // MÉTODOS AUXILIARES
    @PreRemove
    public void setNullCitas() {
        citas.forEach(cita -> {
            cita.setCliente(null);
        });
    }

}
