// mco-server is a game server, written from scratch, for an old game
// Copyright (C) <2017-2018>  <Joseph W Becher>

// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

const { ConnectionMgr } = require('./connectionMgr')

const { ListenerThread } = require('./listenerThread')
const { Logger } = require('../shared/loggerManager')

/**
 *
 */
class MCServer {
  /**
   *
   * @param {string} configFilePath - file path to the configuration file
   */
  constructor (configFilePath) {
    this.mgr = new ConnectionMgr(configFilePath)
    this.logger = new Logger().getLogger('MCServer')
  }

  /**
   * Start the HTTP, HTTPS and TCP connection listeners
   * @param {IServerConfiguration} config
   */

  async startServers (config) {
    const listenerThread = new ListenerThread()
    this.logger.info('[MCServer] Starting the listening sockets...')
    const tcpPortList = [
      6660,
      8228,
      8226,
      7003,
      8227,
      43200,
      43300,
      43400,
      53303,
      9000,
      9001,
      9002,
      9003,
      9004,
      9005,
      9006,
      9007,
      9008,
      9009,
      9010,
      9011,
      9012,
      9013,
      9014
    ]

    await tcpPortList.map((port) =>
      listenerThread.startTCPListener(port, this.mgr, config)
    )
    this.logger.info('[MCServer] Listening sockets create successfully.')
  }
}

module.exports = {
  MCServer
}