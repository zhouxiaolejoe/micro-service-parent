package com.micro.service.springquartz.test.chain;

/**
 * @Description
 * @Project microfasp-jiangsu
 * @Package gov.mof.fasp3.masterdata.test.chain
 * @Author zxl
 * @Date 2022-09-06 14:50
 */
public class TestChain {

    public static void main(String[] args) {
        int[][] arrays = {{60, 60}, {40, 40}, {40, 60}, {60, 40}};
        for (int[] array : arrays) {
            ProcessorChain processorChain = new ProcessorChain();
            processorChain.addProcessor(new LengthCheckProcessor());
            processorChain.addProcessor(new WidthCheckProcessor());

            Product product = new Product(array[0], array[1]);
            boolean checkResult = processorChain.process(product, processorChain);
            if (checkResult) {
                System.out.println("产品最终检验合格");
            } else {
                System.out.println("产品最终检验不合格");
            }
            System.out.println();
        }
    }
}
