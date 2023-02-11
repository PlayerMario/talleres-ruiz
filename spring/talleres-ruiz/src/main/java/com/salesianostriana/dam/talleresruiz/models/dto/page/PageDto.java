package com.salesianostriana.dam.talleresruiz.models.dto.page;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;
import com.salesianostriana.dam.talleresruiz.models.dto.cliente.ClienteViews;
import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PageDto<T> {

    @JsonView(PageViews.Master.class)
    private List<T> content;
    @JsonView(PageViews.Master.class)
    private Long totalElements;
    @JsonView(PageViews.Master.class)
    private int totalPages;
    @JsonView(PageViews.Master.class)
    private int number;
    @JsonView(PageViews.Master.class)
    private int size;

    public PageDto(Page<T> page) {
        this.content = page.getContent();
        this.totalElements = page.getTotalElements();
        this.totalPages = page.getTotalPages();
        this.number = page.getNumber();
        this.size = page.getSize();
    }

}
