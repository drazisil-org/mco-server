// mco-server is a game server, written from scratch, for an old game
// Copyright (C) <2017-2018>  <Joseph W Becher>

// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

const {
  LoginServer
} = require('../../../src/services/MCServer/LoginServer/LoginServer')
const tap = require('tap')

const loginServer = new LoginServer()

tap.test('LoginServer', t => {
  const { customerId, userId } = loginServer._npsGetCustomerIdByContextId(
    'd316cd2dd6bf870893dfbaaf17f965884e'
  )
  t.equal(customerId.readUInt32BE(0).toString(), '5551212')
  t.equal(userId.readUInt32BE(0).toString(), '1')
  t.done()
})

tap.test('LoginServer', t => {
  const { customerId, userId } = loginServer._npsGetCustomerIdByContextId(
    '5213dee3a6bcdb133373b2d4f3b9962758'
  )
  t.equal(customerId.readUInt32BE(0).toString(), '2885746688')
  t.equal(userId.readUInt32BE(0).toString(), '2')
  t.done()
})
