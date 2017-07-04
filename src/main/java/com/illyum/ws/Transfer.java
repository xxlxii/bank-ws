package com.illyum.ws;

import java.math.BigDecimal;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.illyum.types.TransferRequest;
import com.illyum.types.TransferResponse;

@RestController
public class Transfer {

	private DataSource dataSource;

	public Transfer(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@RequestMapping(method = RequestMethod.POST, path = "/ws/transfer")
	public ResponseEntity<TransferResponse> execute(@RequestBody TransferRequest request) {

		MapSqlParameterSource input = new MapSqlParameterSource();
		input.addValue("NoCuentaOrigen", request.getSourceAccount());
		input.addValue("NoCuentaDestino", request.getTargetAccount());
		input.addValue("Monto", request.getAmount());
		input.addValue("SaldoAnteriorOrigen", BigDecimal.ZERO);
		input.addValue("SaldoNuevoOrigen", BigDecimal.ZERO);
		input.addValue("SaldoAnteriorDestino", BigDecimal.ZERO);
		input.addValue("SaldoNuevoDestino", BigDecimal.ZERO);
		
		SimpleJdbcCall sp = new SimpleJdbcCall(dataSource);		
		sp.withProcedureName("Transferencia");

		Map<String, Object> output = sp.execute(input);
		TransferResponse response = new TransferResponse
		(
			(BigDecimal) output.get("SaldoAnteriorOrigen"),
			(BigDecimal) output.get("SaldoNuevoOrigen"),
			(BigDecimal) output.get("SaldoAnteriorDestino"),
			(BigDecimal) output.get("SaldoNuevoDestino")
		);

		return new ResponseEntity<TransferResponse>(response, HttpStatus.OK);

	}

}
