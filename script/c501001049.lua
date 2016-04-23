---エルシャドール・ネフィリム
function c501001049.initial_effect(c)
	--
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(c501001049.fumfilter1)
							,aux.FilterBoolFunction(c501001049.fumfilter2)
							,true)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c501001049.splimit)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001049,0))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c501001049.tgtg)
	e2:SetOperation(c501001049.tgop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26593852,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetTarget(c501001049.destg)
	e3:SetOperation(c501001049.desop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(501001049,2))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetTarget(c501001049.thtg)
	e4:SetOperation(c501001049.thop)
	c:RegisterEffect(e4)
end	
function c501001049.fumfilter1(c)
	return c:IsCanBeFusionMaterial()
	and c:IsSetCard(0x9b)
end
function c501001049.fumfilter2(c)
	return c:IsCanBeFusionMaterial()
	and (c:IsAttribute(ATTRIBUTE_LIGHT)
		or (c:IsCode(501001073) and c:GetFlagEffect(c:GetCode())==1)
		)
end
function c501001049.splimit(e,se,sp,st)
	local c=e:GetHandler()
	return not c:IsLocation(LOCATION_EXTRA)
	or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c501001049.tgfilter(c)
	return c:IsAbleToGrave()
	and c:IsSetCard(0x9b)
end
function c501001049.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001049.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end	
function c501001049.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001049.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end	
function c501001049.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	if a==c then tc=t else tc=a end
	if chk==0 then return tc and bit.band(tc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL end
	Duel.SetOperationInfo(tp,CATEGORY_DESTROY,tc,1,tp,LOCATION_MZONE)
end
function c501001049.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	if a==c then tc=t else tc=a end
	if tc:IsRelateToBattle() then Duel.Destroy(tc,REASON_EFFECT) end
end
function c501001049.thfilter(c)
	return c:IsAbleToHand()
	and c:IsSetCard(0x9b)
	and (c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP))
end
function c501001049.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(c501001049.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,c501001049.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,tp,LOCATION_GRAVE)
end	
function c501001049.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		Duel.ShuffleHand(tp)
	end
end	
