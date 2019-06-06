/**
 * Created by luo yu shi on 2017/1/10.
 * @flow
 */

'use strict';

import BaseModule from 'chameleon-ui/lib/BusinessBase'
import page from './PageConfig'
//
import AutoRepay from './page'
import PageDeduct from './page/PageDeduct'
/**
 * 2017/02/24
 * 3.9.9
 *  预发布
 *   jumpType: 12
 *   jumpUrl: AutoRepay?errJumpType=8&errJumpUrl=http%3A%2F%2Fminner.jr.jd.com%2Fjdbt%2Fautopayment%2Frn-web%2F
 *
    线上
    jumpType: 12,
    jumpUrl: AutoRepay?errJumpType=8&errJumpUrl=http%3A%2F%2Fm.jr.jd.com%2Fjdbt%2Fautopayment%2Frn-web%2Findex.html
 */

BaseModule.registerPage(AutoRepay, page.page_auto_repay);
BaseModule.registerPage(PageDeduct, page.page_deduct);
BaseModule.registerFirstPage(page.page_auto_repay);