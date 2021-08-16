package com.micro.service.springredis;

import com.google.common.base.Splitter;
import lombok.extern.slf4j.Slf4j;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//@SpringBootTest
//@RunWith(SpringRunner.class)
@Slf4j
public class MicroServiceSpringRedisApplicationTests {
//
//    @Autowired
//    RedisTemplate redisTemplate;

//    @Test
//    public void contextLoads() {
//        redisTemplate.opsForValue().set("k1","v1");
//        String k1 = redisTemplate.opsForValue().get("k1").toString();
//        log.info(k1);
//    }
    String regex = "^[a-zA-Z0-9]{1,160}$|^[a-zA-Z0-9][a-zA-Z0-9_\\-.]{0,158}[a-zA-Z0-9]$}";
    Pattern pattern = Pattern.compile(regex);
    @Test
    public void test1() {
        String s = "gov.mof.fasp3.dic3.finance.column.api.v1.DicColumnController,gov.mof.fasp3.masterdata.nantong.collector.arperson.api.v1.ArpersonDataApiController,gov.mo" +
                "f.fasp3.masterdata.verifysearching.api.v1.MiddlePublishMateDatasController,gov.mof.fasp3.dic3.restapi.v1.norm.collector.api.v1.NormMainDatasPublishAPICo" +
                "ntroller,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvpay.api.v1.FpmvpayController,gov.mof.fasp3.masterdata.mainranges.basindicator.api.v1.MasterRang" +
                "esBasIndiCatorApiController,gov.mof.fasp3.masterdata.maincollector.basindicator.api.v1.MasterBasIndiCatorRangesController,gov.mof.fasp3.dic3.restapi.v1." +
                "norm.ranges.api.v1.NormDataRangesApiContoller,gov.mof.fasp3.dic3.basicdata.range.ui.api.v1.BasicDataController,gov.mof.fasp3.masterdata.maincollector.pe" +
                "rfindicatortemp.api.v1.MasterPerfTempInfoRangesController,gov.mof.fasp3.masterdata.nantong.ranges.apperson.api.v1.RangesAppersonApiController,gov.mof.fa" +
                "sp3.dic3.basicdata.admdiv.api.v1.DataRangeAdmdivController,gov.mof.fasp3.masterdata.mainranges.nontaxrelation.api.v1.MasterRangesNonTaxRelationApiContro" +
                "ller,gov.mof.fasp3.dic3.basicdata.version.api.v1.BasicDataVersionController,gov.mof.fasp3.masterdata.nantong.ranges.arperson.api.v1.RangesArpersonApiCon" +
                "troller,gov.mof.fasp3.masterdata.mainranges.mofdivranges.api.v1.MasterRangesMofdivApiController,gov.mof.fasp3.dic3.metadata.physical.table.restapi.Table" +
                "DBVersionRestAPI,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvdirectfunds.api.v1.FpmvdirectfundsController,gov.mof.fasp3.dic3.restapi.v1.norm.actual." +
                "api.v1.NormActualDataRangesApiContoller,gov.mof.fasp3.masterdata.mainranges.pmgoalinfo.api.v1.MasterRangesPMGoalInfoApiController,gov.mof.fasp3.masterda" +
                "ta.nantong.ranges.gsperson.api.v1.RangesGspersonApiController,gov.mof.fasp3.masterdata.maincollector.assetlimit.api.v1.MasterAssetLimitRangesController," +
                "gov.mof.fasp3.masterdata.mainranges.perfindicatorcase.api.v1.MasterRangesPerfCaseApiController,gov.mof.fasp3.dic3.finance.dataset.api.v1.FinanceDataSetC" +
                "ontroller,gov.mof.fasp3.masterdata.mainranges.assetext.api.v1.MasterRangesAssetExtApiController,gov.mof.fasp3.dic3.finance.table.api.v1.DicTableControll" +
                "er,gov.mof.fasp3.masterdata.mainranges.pmprojectinfo.api.v1.MasterRangesPMProjectInfoApiController,gov.mof.fasp3.masterdata.manage.api.v1.MasterDataMana" +
                "geController,gov.mof.fasp3.masterdata.mainranges.officeinfo.api.v1.MasterRangesOfficeInfoApiController,gov.mof.fasp3.masterdata.mainranges.nottaxdetail." +
                "api.v1.MasterRangesNotTaxDetailApiController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvbdgagency.api.v1.FpmvbdgagencyController,gov.mof.fasp3.dic3" +
                ".finance.catalog.api.v1.CatalogOperationController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvsubsidy.api.v1.FpmvsubsidyController,gov.mof.fasp3.di" +
                "c3.basicdata.restapi.v1.BasicDataDicRangesController,gov.mof.fasp3.masterdata.mainranges.agencyext.api.v1.MasterRangesAgencyExtApiController,gov.mof.fas" +
                "p3.masterdata.nantong.collector.agencycom.api.v1.AgencycomDataApiController,gov.mof.fasp3.masterdata.maincollector.nottaxdetail.api.v1.MasterNotTaxDetai" +
                "lRangesController,gov.mof.fasp3.masterdata.maincollector.assetext.api.v1.MasterAssetExtRangesController,gov.mof.fasp3.dic3.finance.range.api.v1.FinanceD" +
                "ataRangeController,gov.mof.fasp3.dic3.maindata.promain.api.v1.BasicPromainRangesController,gov.mof.fasp3.dic3.basicdata.restapi.v1.BasicMainFunctionApiC" +
                "ontroller,gov.mof.fasp3.masterdata.mainranges.general.v1.MasterRangesCommonController,gov.mof.fasp3.dic3.maindata.paydir.api.v1.BasicExpdirectRangesCont" +
                "roller,gov.mof.fasp3.masterdata.maincollector.mastermofdiv.api.v1.MasterMofdivRangesController,gov.mof.fasp3.dic3.basicdata.tmpversion.api.v1.BasicDataT" +
                "mpVersionController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvsetmode.api.v1.FpmvsetmodeController,gov.mof.fasp3.masterdata.mainranges.causerrange" +
                "s.api.v1.MasterRangesCauserApiController,gov.mof.fasp3.masterdata.mainranges.officecar.api.v1.MasterRangesOfficeCarApiController,gov.mof.fasp3.dic3.basi" +
                "cdata.api.v1.VersionApi,gov.mof.fasp3.dic3.directory.data.api.v1.ExportDataController,gov.mof.fasp3.masterdata.mainranges.perfindicatortemp.api.v1.Maste" +
                "rRangesPerfTempApiController,gov.mof.fasp3.masterdata.mainranges.nottax.api.v1.MasterRangesNottaxApiController,gov.mof.fasp3.masterdata.nantong.collecto" +
                "r.ipperson.api.v1.IppersonDataApiController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvgovexpeconormic.api.v1.FcController,gov.mof.fasp3.dic3.basic" +
                "data.restapi.v1.BasicMainDataDepartmentApiController,gov.mof.fasp3.dic3.basicdata.dataset.api.v1.BasicDataCodeListController,gov.mof.fasp3.masterdata.ma" +
                "incollector.projectinfo.api.v1.MasterProjectInfoRangesController,gov.mof.fasp3.masterdata.maincollector.agency.api.v1.MasterAgencyRangesController,gov.m" +
                "of.fasp3.masterdata.nantong.collector.gsperson.api.v1.GspersonDataApiController,gov.mof.fasp3.masterdata.maincollector.pmgoalinfo.api.v1.MasterPMGoalInf" +
                "oRangesController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvexpfunc.api.v1.FpmvexpfuncController,gov.mof.fasp3.dic3.basicdata.dataelement.api.v1.B" +
                "asicDataElementManageController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvfundtype.api.v1.FpmvfundtypeController,gov.mof.fasp3.masterdata.mainrang" +
                "es.pmindicator.api.v1.MasterRangesPMIndiCatorApiController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvindiapi.api.v1.FpmvindiapiController,gov.mof." +
                "fasp3.dic3.basicdata.api.v1.CommonDataRangeApi,gov.mof.fasp3.masterdata.maincollector.porlist.api.v1.MasterProlistRangesController,gov.mof.fasp3.masterd" +
                "ata.maincollector.pmindicator.api.v1.MasterPMIndiCatorRangesController,gov.mof.fasp3.dic3.restapi.v1.commonService.authority.appid.api.v1.SecAppidAccess" +
                "PowerController,gov.mof.fasp3.masterdata.mainranges.agency.api.v1.MasterRangesAgencyApiController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvbdgman" +
                "agedivision.api.v1.FController,gov.mof.fasp3.dic3.finance.structure.api.v1.DefaultStructureController,gov.mof.fasp3.masterdata.nantong.collector.fundcha" +
                "nge.api.v1.FundchangeDataApiController,gov.mof.fasp3.masterdata.maincollector.pmprojectinfo.api.v1.MasterPMProjectInfoRangesController,gov.mof.fasp3.mas" +
                "terdata.mainranges.assetlimit.api.v1.MasterRangesAssetLimitApiController,gov.mof.fasp3.masterdata.nantong.collector.irperson.api.v1.IrpersonDataApiContr" +
                "oller,gov.mof.fasp3.dic3.basicdata.agency.api.v1.DataRangeAgencyController,gov.mof.fasp3.masterdata.maincollector.agencyext.api.v1.MasterAgencyExtRanges" +
                "Controller,gov.mof.fasp3.dic3.directory.version.api.v1.VersionController,gov.mof.fasp3.masterdata.nantong.ranges.agencycom.api.v1.RangesAgencyComApiCont" +
                "roller,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvindi.api.v1.FpmvindiController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvpaytype.api.v1.Fpm" +
                "vpaytypeController,gov.mof.fasp3.masterdata.nantong.ranges.fundchange.api.v1.RangesFundchangeApiController,gov.mof.fasp3.masterdata.mainranges.general.v" +
                "1.MasterGeneralController,gov.mof.fasp3.dic3.basicdata.range.ui.api.v1.BasicDataCommonRangeController,gov.mof.fasp3.dic3.basicdata.restapi.v1.BasicMainD" +
                "ataRangesApiController,gov.mof.fasp3.masterdata.maincollector.pmevaluateinfo.api.v1.MasterPMEvaluateInfoRangesController,gov.mof.fasp3.dic3.maindata.mdm" +
                "project.api.v1.BasicDataIndiRangesController,gov.mof.fasp3.masterdata.mainranges.pmevaluateinfo.api.v1.MasterRangesPMEvaluateInfoApiController,gov.mof.f" +
                "asp3.dic3.basicdata.department.api.v1.DataRangeDepartmentController,gov.mof.fasp3.masterdata.maincollector.officeinfo.api.v1.MasterOfficeInfoRangesContr" +
                "oller,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvexpeconormic.api.v1.FpmvexpeconormicController,gov.mof.fasp3.masterdata.nantong.collector.apperson" +
                ".api.v1.AppersonDataApiController,gov.mof.fasp3.masterdata.maincollector.asset.api.v1.MasterAssetRangesController,gov.mof.fasp3.dic3.basicdata.range.ui." +
                "api.v1.DataRangeController,gov.mof.fasp3.dic3.directory.data.api.v1.DataDirectoryController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvqksfbs.api.v" +
                "1.FpmvqksfbsController,gov.mof.fasp3.masterdata.mainranges.asset.api.v1.MasterRangesAssetApiController,gov.mof.fasp3.masterdata.maincollector.perfindica" +
                "torcase.api.v1.MasterPerfCaseInfoRangesController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvaccttype.api.v1.FpmvaccttypeController,gov.mof.fasp3.d" +
                "ic3.basicdata.restapi.v1.DicRangeRestAPI,gov.mof.fasp3.dic3.basicdata.range.ui.api.v1.BasicDataRangeController,gov.mof.fasp3.masterdata.maincollector.of" +
                "ficecar.api.v1.MasterOfficeCarRangesController,gov.mof.fasp3.masterdata.maincollector.mastercauser.api.v1.MasterCauserRangesController,gov.mof.fasp3.dic" +
                "3.basicdata.range.ui.api.v1.BasicDataSetController,gov.mof.fasp3.masterdata.maincollector.zdzj.fpmvprovince.api.v1.FpmvprovinceController,gov.mof.fasp3." +
                "dic3.finance.element.api.v1.LibraryTableElementsController,gov.mof.fasp3.dic3.basicdata.range.ui.api.v1.BasicDataSetTypeController,gov.mof.fasp3.masterd" +
                "ata.mainranges.projectinfo.api.v1.MasterRangesProjectInfoApiController,gov.mof.fasp3.masterdata.nantong.ranges.irperson.api.v1.RangesIrpersonApiControll" +
                "er,gov.mof.fasp3.masterdata.maincollector.nontaxrelation.api.v1.MasterNonTaxRelationRangesController,gov.mof.fasp3.masterdata.nantong.ranges.ipperson.ap" +
                "i.v1.RangesIppersonApiController,gov.mof.fasp3.masterdata.maincollector.nontaxprogram.api.v1.MasterNotTaxRangesController,gov.mof.fasp3.masterdata.mainc" +
                "ollector.zdzj.fpmvzdzjjqpt.api.v1.FpmvzdzjjqptController";
        List<String> strings = Splitter.on(",").trimResults().splitToList(s);
        for (String string : strings) {
            int length = string.length();
            System.err.println(length);
            if(length>=100){
                System.err.println(string);
            }
        }
    }

}
