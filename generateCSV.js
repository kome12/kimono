"use strict";
const fs = require("fs");

const readFilePathNihon = "./raw_data/nihon_raw_table_data.csv";
const readFilePathBasic = "./raw_data/basic_raw_table_data.csv";

const readFilePathStudentResponseNihon =
  "./raw_data/student_response_nihon.csv";
const readFilePathStudentResponseBasic =
  "./raw_data/student_response_basic.csv";

const indexToTypeMapping = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
];

const readAggregatedData = (filePath) => {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, "utf8", (err, data) => {
      if (err) {
        const errMsg = `Error reading file for ${filePath}: ${err}`;
        console.error(errMsg);
        reject(errMsg);
      }
      resolve(data);
    });
  });
};

const writeToCSV = (filePath, data) => {
  return new Promise((resolve, reject) => {
    fs.writeFile(filePath, data, (err) => {
      if (err) {
        const errMsg = `Error writing file for ${filePath}: ${err}`;
        console.error(errMsg);
        reject(errMsg);
      }
      resolve();
    });
  });
};

const formatData = (data, categoryType = "NH") => {
  const splittedData = data.split("\n");
  const finalOutput = splittedData.reduce((arr, row, index) => {
    const splitRow = row.split(",");
    if (index >= 3) {
      const rowRank = splitRow[0];
      const rowArr = splitRow.reduce((rowArray, item, index) => {
        if (index > 0 && item > 0) {
          const letterType = indexToTypeMapping[index - 1];
          const template = `${
            13 - rowRank
          },${letterType} - ${categoryType},${letterType}`;
          const itemArray = new Array(+item).fill(template);
          rowArray.push(...itemArray);
        }
        return rowArray;
      }, []);
      arr.push(...rowArr);
    }
    return arr;
  }, []);
  return finalOutput.join("\n");
};

const violinPlot = async (filePath) => {
  const header = "Rank,CategoryType,Type\n";
  const csvDataNihon = await readAggregatedData(readFilePathNihon);
  const nihonData = formatData(csvDataNihon);

  const csvDataBasic = await readAggregatedData(readFilePathBasic);
  const basicData = formatData(csvDataBasic, "BA");

  await writeToCSV(filePath + "kimono_nihon_data.csv", header + nihonData);
  await writeToCSV(filePath + "kimono_basic_data.csv", header + basicData);
};

const formatForScatterPlotData = (nihonData, basicData) => {
  const aggregated = [];
  const sumByType = new Array(indexToTypeMapping.length)
    .fill({})
    .map((type) => ({
      nihon: 0,
      basic: 0,
    }));
  const splittedNihonData = nihonData.split("\n");
  const splittedBasicData = basicData.split("\n");
  for (let i = 1; i < splittedNihonData.length; i++) {
    const row = [];
    const nihonRow = splittedNihonData[i];
    const basicRow = splittedBasicData[i];
    const splitNihonRow = nihonRow.replace("\r", "").split(",");
    const splitBasicRow = basicRow.replace("\r", "").split(",");
    for (let j = 0; j < splitNihonRow.length; j++) {
      aggregated.push(
        `${splitNihonRow[j]},${splitBasicRow[j]},${indexToTypeMapping[j]}`
      );
      sumByType[j].nihon += +splitNihonRow[j];
      sumByType[j].basic += +splitBasicRow[j];
    }
  }
  const sumByTypeCombined = sumByType.map((splitSum, index) => {
    const combinedResult = `${indexToTypeMapping[index]},${splitSum.nihon},${splitSum.basic}`;
    return combinedResult;
  }, "");
  const finalResult = {
    aggregated,
    sumByTypeCombined,
  };
  return finalResult;
};

const scatterPlot = async (filePath) => {
  const headers = `Nihon,Basic,Type\n`;
  const sumByTypeHeaders = `Type,Nihon,Basic\n`;

  const studentDataNihon = await readAggregatedData(
    readFilePathStudentResponseNihon
  );

  const studentDataBasic = await readAggregatedData(
    readFilePathStudentResponseBasic
  );

  const data = formatForScatterPlotData(studentDataNihon, studentDataBasic);
  await writeToCSV(
    filePath + "student_response_aggregated.csv",
    headers + data.aggregated.join("\n")
  );
  await writeToCSV(
    filePath + "student_response_sum_by_type.csv",
    sumByTypeHeaders + data.sumByTypeCombined.join("\n")
  );
};

const getAndFormatData = async () => {
  const filePath = "./raw_data/";
  // violinPlot(filePath);

  scatterPlot(filePath);
};

getAndFormatData();
