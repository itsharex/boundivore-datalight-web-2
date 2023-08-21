/**
 * Copyright (C) <2023> <Boundivore> <boundivore@foxmail.com>
 * <p>
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the Apache License, Version 2.0
 * as published by the Apache Software Foundation.
 * <p>
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * Apache License, Version 2.0 for more details.
 * <p>
 * You should have received a copy of the Apache License, Version 2.0
 * along with this program; if not, you can obtain a copy at
 * http://www.apache.org/licenses/LICENSE-2.0.
 */
package cn.boundivore.dl.service.master.controller;

import cn.boundivore.dl.api.master.define.IMasterConfigAPI;
import cn.boundivore.dl.base.request.impl.master.ConfigSaveByGroupRequest;
import cn.boundivore.dl.base.request.impl.master.ConfigSaveRequest;
import cn.boundivore.dl.base.response.impl.master.ConfigListByGroupVo;
import cn.boundivore.dl.base.response.impl.master.ConfigSummaryListVo;
import cn.boundivore.dl.base.result.Result;
import cn.boundivore.dl.service.master.service.MasterConfigService;
import cn.boundivore.dl.service.master.service.MasterConfigSyncService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

/**
 * Description: MasterConfigController
 * Created by: Boundivore
 * E-mail: boundivore@foxmail.com
 * Creation time: 2023/3/30
 * Modification description:
 * Modified by:
 * Modification time:
 * Version: V1.0
 */
@RestController
@RequiredArgsConstructor
public class MasterConfigController implements IMasterConfigAPI {

    private final MasterConfigService masterConfigService;

    private final MasterConfigSyncService masterConfigSyncService;

    @Override
    public Result<String> configSave(ConfigSaveRequest request) throws Exception {
        return this.masterConfigSyncService.configSaveOrUpdateBatch(request) ?
                Result.success() :
                Result.fail();
    }

    @Override
    public Result<ConfigSummaryListVo> configListSummary(Long clusterId, String serviceName) throws Exception {
        return this.masterConfigService.getConfigListSummary(
                clusterId,
                serviceName
        );
    }

    @Override
    public Result<ConfigListByGroupVo> configListByGroup(Long clusterId,
                                                         String serviceName,
                                                         String filename,
                                                         String configPath) throws Exception {
        return this.masterConfigService.getConfigListByGroup(
                clusterId,
                serviceName,
                configPath
        );
    }

    @Override
    public Result<String> configSaveByGroup(ConfigSaveByGroupRequest request) throws Exception {
        return this.masterConfigSyncService.configSaveByGroupSync(request);
    }


}