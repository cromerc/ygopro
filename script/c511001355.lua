--Relationship
function c511001355.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001355.target)
	e1:SetOperation(c511001355.activate)
	c:RegisterEffect(e1)
	if not c511001355.global_check then
		c511001355.global_check=true
		c511001355[0]=Group.CreateGroup()
		c511001355[0]:KeepAlive()
		c511001355[1]=Group.CreateGroup()
		c511001355[1]:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c511001355.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001355.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001355.cfilter(c,atk)
	return c:GetTextAttack()==atk
end
function c511001355.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsType,nil,TYPE_MONSTER)
	local tc=g:GetFirst()
	while tc do
		local sg=Duel.GetMatchingGroup(c511001355.cfilter,tp,0xff,0xff,nil,tc:GetTextAttack())
		c511001355[tc:GetPreviousControler()]:Merge(sg)
		tc=g:GetNext()
	end
end
function c511001355.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001355[0]:Clear()
	c511001355[1]:Clear()
end
function c511001355.filter(c,e,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_HAND+LOCATION_DECK) and c:IsSetCard(0x3008) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001355.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=c511001355[tp]:Filter(c511001355.filter,nil,e,tp)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001355.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=c511001355[tp]:Filter(c511001355.filter,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,1,1,nil)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
