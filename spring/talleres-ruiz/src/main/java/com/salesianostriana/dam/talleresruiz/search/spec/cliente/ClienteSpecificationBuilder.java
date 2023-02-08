package com.salesianostriana.dam.talleresruiz.search.spec.cliente;

import com.salesianostriana.dam.talleresruiz.models.Cliente;
import com.salesianostriana.dam.talleresruiz.search.spec.generic.GenericSpecificationBuilder;
import com.salesianostriana.dam.talleresruiz.search.util.SearchCriteria;

import java.util.List;

public class ClienteSpecificationBuilder extends GenericSpecificationBuilder<Cliente> {

    public ClienteSpecificationBuilder(List<SearchCriteria> params) {
        super(params, Cliente.class, Cliente.hiddenFields);
    }

}
