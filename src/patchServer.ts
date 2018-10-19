// mco-server is a game server, written from scratch, for an old game
// Copyright (C) <2017-2018>  <Joseph W Becher>

// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import * as http from "http";

import { IServerConfiguration } from "./IServerConfiguration";
import { ILoggerInstance } from "./logger";

/**
 * A simulated patch server response
 */
const castanetResponse = {
  body: Buffer.from("cafebeef00000000000003", "hex"),
  header: {
    type: "Content-Type",
    value: "application/octet-stream",
  },
};

/**
 * Simulate a response from a patch server
 */
function patchUpdateInfo() {
  return castanetResponse;
}

/**
 * Simulate a response from a patch server
 */
function patchNPS() {
  return castanetResponse;
}

/**
 * Simulate a response from a patch server
 */
function patchMCO() {
  return castanetResponse;
}

/**
 * Generate a shard list web document
 * @param {JSON} config
 */
function generateShardList(serverConfig: IServerConfiguration["serverConfig"]) {
  return `[The Clocktower]
  Description=The Clocktower
  ShardId=44
  LoginServerIP=${serverConfig.ipServer}
  LoginServerPort=8226
  LobbyServerIP=${serverConfig.ipServer}
  LobbyServerPort=7003
  MCOTSServerIP=${serverConfig.ipServer}
  StatusId=0
  Status_Reason=
  ServerGroup_Name=Group - 1
  Population=88
  MaxPersonasPerUser=2
  DiagnosticServerHost=${serverConfig.ipServer}
  DiagnosticServerPort=80`;
  // [Twin Pines Mall]
  //   Description=Twin Pines Mall
  //   ShardId=88
  //   LoginServerIP=mc.drazisil.com
  //   LoginServerPort=8226
  //   LobbyServerIP=mc.drazisil.com
  //   LobbyServerPort=7003
  //   MCOTSServerIP=mc.drazisil.com
  //   StatusId=0
  //   Status_Reason=
  //   ServerGroup_Name=Group - 1
  //   Population=88
  //   MaxPersonasPerUser=2
  //   DiagnosticServerHost=mc.drazisil.com
  //   DiagnosticServerPort=80
  // [Marty's House]
  //   Description=Marty's House
  //   ShardId=22
  //   LoginServerIP=192.168.1.14
  //   LoginServerPort=8226
  //   LobbyServerIP=192.168.1.14
  //   LobbyServerPort=7003
  //   MCOTSServerIP=192.168.1.14
  //   StatusId=0
  //   Status_Reason=
  //   ServerGroup_Name=Group - 1
  //   Population=88
  //   MaxPersonasPerUser=2
  //   DiagnosticServerHost=192.168.5.14
  //   DiagnosticServerPort=80`;
}

export class PatchServer {
  public logger: ILoggerInstance;
  private banList: string[] = [];

  constructor(logger: ILoggerInstance) {
    this.logger = logger;
  }

  public _httpHandler(
    request: http.IncomingMessage,
    response: http.ServerResponse,
    serverConfiguration: IServerConfiguration,
    logger: ILoggerInstance
  ) {
    let responseData;
    switch (request.url) {
      case "/ShardList/":
        response.setHeader("Content-Type", "text/plain");
        response.end(generateShardList(serverConfiguration.serverConfig));
        break;

      case "/games/EA_Seattle/MotorCity/UpdateInfo":
        responseData = patchUpdateInfo();
        response.setHeader(responseData.header.type, responseData.header.value);
        response.end(responseData.body);
        break;
      case "/games/EA_Seattle/MotorCity/NPS":
        responseData = patchNPS();
        response.setHeader(responseData.header.type, responseData.header.value);
        response.end(responseData.body);
        break;
      case "/games/EA_Seattle/MotorCity/MCO":
        responseData = patchMCO();
        response.setHeader(responseData.header.type, responseData.header.value);
        response.end(responseData.body);
        break;

      default:
        // Is this a hacker?
        if (this.banList.indexOf(request.socket.remoteAddress!) < 0) {
          // In ban list, skip
          break;
        }
        // Unknown request, log it
        logger.debug(
          `[PATCH] Unknown Request from ${request.socket.remoteAddress} for ${
            request.method
          } ${request.url}, banning.`
        );
        this.banList.push(request.socket.remoteAddress!);
        response.end("foo");
        break;
    }
  }

  public getBans() {
    return this.banList;
  }

  public async start(configurationFile: IServerConfiguration) {
    const serverPatch = http.createServer((req, res) => {
      this._httpHandler(req, res, configurationFile, this.logger);
    });
    serverPatch.listen({ port: "80", host: "0.0.0.0" }, () => {
      this.logger.debug("[patchServer] Patch server is listening...");
    });
  }
}