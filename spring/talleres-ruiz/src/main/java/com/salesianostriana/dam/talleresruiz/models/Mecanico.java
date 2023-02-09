package com.salesianostriana.dam.talleresruiz.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.salesianostriana.dam.talleresruiz.models.user.User;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.UUID;

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
    @Column(columnDefinition = "uuid")
    private UUID id;

    @MapsId("id")
    @JsonIgnore
    @JoinColumn(name = "user_entity_id", foreignKey = @ForeignKey(name = "FK_MECANICO_USER"))
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    private User usuario;

    @JsonIgnore
    public static String hiddenFields = "id";

}
