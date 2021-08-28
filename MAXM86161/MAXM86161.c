
#include "MAXM86161.h"
#include "main.h"
#include "string.h"
#include "stm32f4xx.h"

extern I2C_HandleTypeDef hi2c_ppg_max;

/// Actual configuration
MAXM86161_Init_TypeDef ppg_config;

/**
 * Write MAXM86161 register(s)
 */
bool MAXM86161_I2C_Write(uint8_t regName, uint8_t* regValue, uint8_t numBytes) {
	uint8_t tx_buffer[numBytes + 1];
	uint8_t i;
	tx_buffer[0] = regName;
	for (i = 0; i < numBytes; i++)
		tx_buffer[i + 1] = regValue[i];

	return HAL_I2C_Master_Transmit(&hi2c_ppg_max, MAXM86161_I2C_ADDRESS, tx_buffer,
			numBytes + 1, 100) == HAL_OK;
}

/**
 * Read MAXM86161 register(s)
 */
bool MAXM86161_I2C_Read(uint8_t regName, uint8_t* readByte, uint8_t numBytes) {
	bool res = true;
	res &= (HAL_I2C_Master_Transmit(&hi2c_ppg_max, MAXM86161_I2C_ADDRESS, &regName,
			1, 100) == HAL_OK);
	res &= HAL_I2C_Master_Receive(&hi2c_ppg_max, MAXM86161_I2C_ADDRESS, readByte,
			numBytes, 100) == HAL_OK;
	return res;
}

/**
 * Read sensor part ID
 */
uint8_t MAXM86161_Read_Part_ID(void) {
	uint8_t part_id;
	MAXM86161_I2C_Read(MAXM86161_REG_PART_ID, &part_id, 1);
	return part_id;
}

/**
 * Check part ID, revision ID and whether all registers have been written successfully
 */
bool MAXM86161_Check(void) {
	bool check = true;

	// Read PART_ID to check if they are correct
	if (MAXM86161_Read_Part_ID() != MAXM86161_PART_ID_VALUE)
		check = false;

	// Check mode configuration 1
	//TODO
	return check;
}

/**
 * Configuration of MAXM86161 operation
 */
bool MAXM86161_Config(MAXM86161_Init_TypeDef initStruct) {
return true;
}

/**
 * Raw data readout
 */
bool MAXM86161_ReadData(uint8_t* raw_data, uint8_t* len) {
	return true;
}

/**
 * Read data when the module is configured in flex mode
 */
bool MAXM86161_Read_Sample_Flex_Mode(uint8_t* raw_red, uint8_t* raw_ired, uint8_t* raw_green, uint8_t* raw_blue) {

	return true;
}

/**
 * Clear Fifo registers
 */
bool MAXM86161_Clear_Fifo(void) {
	return true;
}
