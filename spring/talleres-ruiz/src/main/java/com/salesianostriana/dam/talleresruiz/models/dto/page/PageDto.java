package com.salesianostriana.dam.talleresruiz.models.dto.page;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cita.CitaViews;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import com.salesianostriana.dam.talleresruiz.models.dto.mecanico.MecanicoViews;
import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PageDto<T> {

    @JsonView({ClienteViews.Master.class, MecanicoViews.Master.class, CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private List<T> content;
    @JsonView({ClienteViews.Master.class, MecanicoViews.Master.class, CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private Long totalElements;
    @JsonView({ClienteViews.Master.class, MecanicoViews.Master.class, CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private int totalPages;
    @JsonView({ClienteViews.Master.class, MecanicoViews.Master.class, CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private int number;
    @JsonView({ClienteViews.Master.class, MecanicoViews.Master.class, CitaViews.Master.class, ClienteViews.DetallesClientes.class})
    private int size;

    public PageDto(Page<T> page) {
        this.content = page.getContent();
        this.totalElements = page.getTotalElements();
        this.totalPages = page.getTotalPages();
        this.number = page.getNumber();
        this.size = page.getSize();
    }

}
