package com.salesianostriana.dam.talleresruiz.models.dto.page;

import lombok.Data;
import org.springframework.data.domain.Page;

import java.util.List;

@Data
public class PageDto<T> {

    private List<T> content;

    private Long totalElements;

    private int totalPages;

    private int number;

    private int size;

    public PageDto(Page<T> page) {
        this.content = page.getContent();
        this.totalElements = page.getTotalElements();
        this.totalPages = page.getTotalPages();
        this.number = page.getNumber();
        this.size = page.getSize();
    }

}
